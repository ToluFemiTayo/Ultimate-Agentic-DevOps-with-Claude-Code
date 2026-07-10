# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.**

- **Type**: Static website (HTML/CSS/JavaScript)
- **Deployment Target**: AWS S3 + CloudFront CDN
- **Infrastructure as Code**: Terraform
- **CI/CD**: GitHub Actions for automated deployments

## Project Structure

```
├── index.html              # Main portfolio page
├── privacy.html            # Privacy policy page
├── terms.html              # Terms of service page
├── style.css               # Single stylesheet for all pages
├── images/                 # Static assets (logo, profile, course images)
└── README.md               # Deployment and ownership documentation
```

## Deployment Commands

### Local Development
No build step required — this is a static site. Open `index.html` directly in a browser or serve locally:

```bash
# Python 3
python -m http.server 8000

# Or Node.js
npx http-server
```

Then visit `http://localhost:8000`

### Deploy to Ubuntu VM

```bash
# 1. SSH into the VM
ssh user@<vm-ip>

# 2. Update system
sudo apt update && sudo apt upgrade -y

# 3. Install Nginx
sudo apt install nginx -y

# 4. Clone repo to Nginx root
cd /var/www
sudo git clone https://github.com/ToluFemiTayo/Ultimate-Agentic-DevOps-with-Claude-Code.git

# 5. Create Nginx config
sudo nano /etc/nginx/sites-available/portfolio
# Copy the config from README.md or use default site pointing to repo root

# 6. Enable site and test
sudo ln -s /etc/nginx/sites-available/portfolio /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# 7. Verify
curl http://localhost
```

### Monitor Deployment

```bash
# Check Nginx status
sudo systemctl status nginx

# View access logs
sudo tail -f /var/log/nginx/access.log

# View error logs
sudo tail -f /var/log/nginx/error.log
```

## Commands

```bash
# Initialize Terraform working directory
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply
```

## Important: Ownership Proof (DMI Requirement)

Before deploying, edit the footer in `index.html` to add your details:

```html
<p><strong>Deployed by:</strong> [Your Name] | [Group] | [Week] | [Date]</p>
```

This is **mandatory** for DMI submission — the proof must be visible in your browser screenshot.

## Conventions

1. **All infrastructure changes go through Terraform** — Never modify AWS resources manually. All changes must be defined in Terraform code and applied through `terraform apply`.
2. **No JavaScript in this project** — Keep the codebase pure HTML5 and CSS3 for simplicity and performance.
3. **CSS uses mobile-first approach** — Breakpoints at 900px, 768px, and 600px for responsive design.

## Safety

**Never put secrets in this file. No API keys, passwords, or AWS credentials.** Sensitive data should be stored in environment variables, AWS Secrets Manager, or `.env` files (ensure `.env` is in `.gitignore`).

## Development Notes

- **No dependencies** — pure HTML/CSS/JavaScript, no build tools needed
- **Responsive design** — uses flexbox and media queries for mobile support
- **Third-party libraries** — Font Awesome icons (loaded via CDN in index.html)
- **Asset paths** — All image links are relative (`images/` folder); ensure assets are kept together when deploying

## Common Tasks

| Task | Command |
|------|---------|
| Test locally | `python -m http.server 8000` then open browser |
| Add a page | Create new `.html` file, add nav link in `index.html` |
| Update styling | Edit `style.css` (single file for all pages) |
| Change footer | Edit the footer `<footer>` section in `index.html` |
| Deploy to prod | Follow "Deploy to Ubuntu VM" section above |

## Architecture Notes

- **Pure HTML5 and CSS3. No JavaScript. No build step. No framework.**
- **Single stylesheet**: `style.css` is shared across all pages (index.html, privacy.html, terms.html)
- **Static hosting**: S3 serves files; CloudFront provides CDN caching and distribution
- **Asset organization**: All images in `images/` folder with relative paths

## Deployment Checklist (DMI)

- [ ] Ownership proof added to footer
- [ ] Site tested locally before VM deployment
- [ ] VM has public IP and inbound HTTP (port 80) open
- [ ] Nginx configured and running
- [ ] Site accessible via public IP
- [ ] Kept live for 24 hours minimum
- [ ] Screenshot submitted as proof
