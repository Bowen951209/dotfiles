import sys
import subprocess
import re
import mimetypes
from email.message import EmailMessage

CID_RE = re.compile(r"\[\s*cid\s*:\s*([^\]]+)\]\(([^)]+)\)")
ATTACMENT_RE = re.compile(r"\[\s*attachment\s*(?::\s*([^\]]*))?\]\(([^)]+)\)")

raw = sys.stdin.read()

in_headers = True
headers = {}
markdown = []
cids = []
attachments = []
for line in raw.splitlines():
    if in_headers and line.strip() == "":
        in_headers = False
        continue

    if in_headers:
        if ":" not in line:
            raise ValueError(f"Invalid header: {line}")

        k, v = line.split(":", 1)
        headers[k.strip()] = v.strip()
    # markdown content, cids, and attachments
    else:
        match_cid = re.search(CID_RE, line)
        if match_cid:
            cids.append((match_cid.group(1), match_cid.group(2)))
        else:
            match_attachment = re.search(ATTACMENT_RE, line);
            if match_attachment:
                attachments.append((match_attachment.group(1), match_attachment.group(2)))
            else: 
                markdown.append(line)

markdown = "\n".join(markdown)
msg = EmailMessage()

for k, v in headers.items():
    msg[k] = v

html = subprocess.run(
    ["pandoc", "-f", "markdown", "-t", "html"],
    input=markdown,
    text=True,
    capture_output=True,
    check=True,
).stdout

msg.set_content(markdown)
msg.add_alternative(html, subtype="html")

html_part = msg.get_payload()[1]

for cid, path in cids:
    mime_type, _ = mimetypes.guess_type(path)
    maintype, subtype = mime_type.split("/", 1)

    with open(path, "rb") as f:
        html_part.add_related(
            f.read(),
            cid=cid,
            maintype=maintype,
            subtype=subtype,
        )

for maybe_name, path in attachments:
    mime_type, _ = mimetypes.guess_type(path)
    maintype, subtype = mime_type.split("/", 1)
    with open(path, "rb") as f:
        msg.add_attachment(
            f.read(),
            maintype=maintype,
            subtype=subtype,
            filename=maybe_name,
        )

# Hack. Delete duplicated MIME-Version header
#for part in msg.walk():
#    if part is not msg and "MIME-Version" in part:
#        del part["MIME-Version"]
print(msg.as_string())
