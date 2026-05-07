/opt/maargali/prod_ansible
├── inventory/
│   └── production.ini
│
├── group_vars/
│   └── all.yml
│
├── roles/
│   ├── common/
│   ├── docker/
│   ├── postgres/
│   ├── nginx/
│   ├── certbot/
│   └── deploy/
│       └── tasks/
│           ├── main.yml
│           └── build-project.yml
│
├── playbooks/
│   ├── setup.yml        # full system setup
│   └── deploy.yml       # deploy single app
│
├── config/              # your .env files
│   ├── fuelman-app.env
│   └── fuelman-ui.env
│
├── files/               # static files (nginx configs, certs, etc.)
├── templates/           # jinja templates
│
├── ansible.cfg
└── README.md
