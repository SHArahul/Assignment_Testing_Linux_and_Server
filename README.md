# Assignment_Testing_Linux_and_Server

## 📘 Project Objective

Set up a secure, monitored, and automated development environment for two new developers. 

**Sarah** and **Mike**, under the guidance of Senior DevOps Engineer Rahul at TechCorp. This environment includes:

- System monitoring setup
- User management and access control
- Automated backup configuration for Apache and Nginx servers

---

##  Tasks & Implementation Details

---

### Task 1: System Monitoring Setup (15 Marks)

> **Objective:** Monitor system health and performance using CLI tools.

**Tools Used:**
- `htop` / `nmon` – CPU, memory, and process monitoring
- `df` – Filesystem usage tracking
- `du` – Directory-level disk usage
- `ps aux` – Identify resource-intensive processes

**Implementation Steps:**
bash
# Install monitoring tools
sudo apt install htop -y

# Monitor disk usage
df -h > /var/log/disk_usage.log
du -sh /home/* >> /var/log/disk_usage.log

# Log top 10 CPU and memory processes
ps aux --sort=-%cpu | head -n 10 > /var/log/high_cpu.log
ps aux --sort=-%mem | head -n 10 > /var/log/high_mem.log
Optional Automation (via cron):

bash
Copy
Edit
# Capture htop snapshot every 12 hours
0 */12 * * * /usr/bin/htop -b -n 1 > /var/log/htop_snapshot.log

Task 2: User Management & Access Control (10 Marks)
Objective: Create isolated user accounts with secure credentials and policies.

Users:

Sarah (/home/Sarah/workspace)

Mike (/home/Mike/workspace)

Steps:

bash
Copy
Edit
# Create users and set secure passwords
sudo useradd -m Sarah
sudo useradd -m Mike
sudo passwd Sarah
sudo passwd Mike

# Create secure workspaces
mkdir -p /home/Sarah/workspace
mkdir -p /home/Mike/workspace
chown Sarah:Sarah /home/Sarah/workspace && chmod 700 /home/Sarah/workspace
chown Mike:Mike /home/Mike/workspace && chmod 700 /home/Mike/workspace
Password Policy Enforcement:

Password expires every 30 days

Requires:

Minimum 10 characters

At least 1 uppercase, 1 lowercase, 1 digit, 1 special character

Edit /etc/login.defs
PASS_MAX_DAYS 30
PASS_MIN_DAYS 1
PASS_WARN_AGE 7

# Enforce complexity (in /etc/pam.d/common-password)
password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1


##Task 3: Automated Backup for Web Servers (20 Marks)
Objective: Schedule weekly backups of web server configurations and document roots.

Sarah (Apache)
Configuration: /etc/httpd/

Web Root: /var/www/html/

Mike (Nginx)
Configuration: /etc/nginx/

Web Root: /usr/share/nginx/html/

Backup Location: /backups/
Format: apache_backup_YYYY-MM-DD.tar.gz, nginx_backup_YYYY-MM-DD.tar.gz

Scripts:

Located in scripts/apache_backup.sh and scripts/nginx_backup.sh

Example:

bash
Copy
Edit
#!/bin/bash
DATE=$(date +%F)
tar -czf /backups/apache_backup_$DATE.tar.gz /etc/httpd/ /var/www/html/
tar -tzf /backups/apache_backup_$DATE.tar.gz > /backups/apache_backup_verify_$DATE.log
Cron Schedule (Every Tuesday @ 12:00 AM):


Copy
Edit
# Edit crontab
0 0 * * 2 /home/Sarah/apache_backup.sh
0 0 * * 2 /home/Mike/nginx_backup.sh


---
---

##Screenshot for each task perform:**
installing htop
![installing and updating htop and its updates](https://github.com/user-attachments/assets/c54e330f-da17-482c-bafd-f7c0a3496829)
---
Htop and five seconds refresh
![htop -d 5 -n 1 output](https://github.com/user-attachments/assets/0bf34183-a08f-4838-9d83-289628ec55ba)
![htop #ss](https://github.com/user-attachments/assets/f9de2c87-2c07-436a-95dd-f2f220f9a1fc)
---
Disk usage
![disk_usage ](https://github.com/user-attachments/assets/fc62ed2e-fe95-4337-86ec-db157c93441c)
![disk usage_root](https://github.com/user-attachments/assets/6d866890-83f7-473b-bd1c-564aa862c4c5)
![total disk usage of home dir](https://github.com/user-attachments/assets/10d5d197-f3dc-4681-8465-f949ddbf8a61)

----
CPU and logs
![cpulogs](https://github.com/user-attachments/assets/7ba70342-6c8d-402a-b0ea-8edd3df78520)
![cpu_intensive log](https://github.com/user-attachments/assets/62912c8f-e563-4fe4-bd82-e749b2cd0266)

---
Adding user sarah and mike
![useradd mike and sarah](https://github.com/user-attachments/assets/35d736ee-2bd7-4fe2-be94-7b63679e2398)
![new user ](https://github.com/user-attachments/assets/87748edc-930c-42fc-927f-8bd89e8d38bb)
![mike and sarah permission dir](https://github.com/user-attachments/assets/fa67bdb2-44cd-49a7-9514-ca9ad755a674)

---
Pass lib
![libpam library](https://github.com/user-attachments/assets/a506bda0-74db-436f-bb3d-6727cba687d0)
pass security and expiration
![password aging ](https://github.com/user-attachments/assets/2df5d68b-b399-4de9-81fe-0e638547318e)
![password min length](https://github.com/user-attachments/assets/ba3f551a-6f63-45a8-be0f-d8e13dc246de)

---
Crontab edit
![crontab screenshot](https://github.com/user-attachments/assets/7e6de026-2f4c-4dca-b32a-d59e7760098b)
---

Backup scripts
![backup apache and nginx files](https://github.com/user-attachments/assets/2f50c2f9-1e42-411a-9c78-c5ff9b22a7aa)
![sarah_backup_script bash](https://github.com/user-attachments/assets/6698fbc8-72ce-472a-a076-2352eb73d0b0)





