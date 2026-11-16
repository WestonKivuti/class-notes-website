# Class Notes Hub

A website where students find lecture notes by semester and download them as PDFs.

## The problem
Students waste time hunting for lecture notes across chats and folders. This site puts notes in one place, filtered by semester.

## Architecture
- VPC `notes-vpc-weston` (10.0.0.0/16) in eu-north-1
- Public subnet (10.0.1.0/24) with a route to an internet gateway, holding the EC2 web server
- Private subnet (10.0.2.0/24) with no route to the internet
- Security group: HTTP (80) from anywhere, SSH (22) from my IP only
- EC2 t3.micro (Amazon Linux 2023), Apache installed by a user data script
- S3 bucket `note-hub-weston-01`, with a bucket policy that allows public read on `public/*` only

## Steps I followed
1. Got the page (`index.html`) written by an AI assistant.
2. Created the S3 bucket, uploaded the PDFs into a `public/` folder, and added the bucket policy.
3. Built the VPC, two subnets, internet gateway and public route table.
4. Created the security group.
5. Wrote `user-data.sh` and launched the EC2 instance with it.
6. Tested the site and the PDF downloads.

## Why we combined the services
1. **Why S3 and not the EC2 server?** S3 is cheap, durable and separate from the server, so if the server is deleted the PDFs stay.
2. **What makes a subnet public?** A route to an internet gateway. The private subnet has no such route, so it is reserved for things like databases.
3. **Why SSH only from My IP but HTTP from anywhere?** Visitors must reach the website, but only I should be able to log in as administrator.
4. **Why `public/*` and not the whole bucket?** Least privilege: only the notes are shared, and everything else stays private.
5. **Why user data?** It builds the server the same way every time, with no manual typing, and it can be reused.

## Problems I hit and how I fixed them
- **Site timed out in Brave.** Brave upgraded the IP address to https, but only port 80 is open. Typing `http://` or using another browser fixed it.
- **User data failed** (`Failed to start cloud-final`). There was a blank line before `#!/bin/bash`, so the script never ran and Apache was not installed. I diagnosed it over SSH with `systemctl status httpd` and by reading `/var/lib/cloud/instance/scripts/part-001`.
- **SSH key permission error on Windows.** Fixed with `icacls` to remove extra access.
- **Pasting into nano cut off my page.** I uploaded the file with `scp` instead.
- **Relaunch.** I fixed the script (line 1 correct, LF line endings), launched a new instance, and confirmed the page was built by user data.

## Clean-up
After marking, all resources are deleted (instance, security group, VPC, bucket, key pair).
