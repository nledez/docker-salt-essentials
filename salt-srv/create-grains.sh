salt -E 'minion(1|2).*' grains.setval myenv prod
salt 'minion3.*' grains.setval myenv stage
salt 'minion4.*' grains.setval myenv dev
salt 'minion1.*' grains.setval roles '[webserver,appserver]'
salt 'minion2.*' grains.setval roles '[database]'
salt -E 'minion(3|4).*' grains.setval roles '[webserver,appserver,database]'
