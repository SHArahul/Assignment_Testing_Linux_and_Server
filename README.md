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
```bash
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

bash
Copy
Edit
# Edit /etc/login.defs
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

bash
Copy
Edit
# Edit crontab
0 0 * * 2 /home/Sarah/apache_backup.sh
0 0 * * 2 /home/Mike/nginx_backup.sh
