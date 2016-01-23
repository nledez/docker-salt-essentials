install_nginx:
  salt.state:
    - tgt: 'web*'
    - sls:
      - nginx
