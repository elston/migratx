PROJECT = migratx
# ..
export DB_NAME = invoice
export DB_USER = invoice
export DB_PASSWORD = passinvoice
# ..



# target:
# target: all - Default target. Does nothing
.PHONY: all
all:
	@echo "Hello $(LOGNAME), nothing to do by default"


# target: help - Display callable targets
.PHONY: help
help:
	@egrep "^# target:|-\ .+" [Mm]akefile --color=auto|column -t -s -

# target:
# target: ===== pull ======== - ============================

# target: pull - pull base images
.PHONY: pull
pull:
	@echo "---> pull mysql:5.7"
	@docker pull mysql:5.7
	@echo "---> pull python:2.7-slim"
	@docker pull python:2.7-slim



# target:
# target: ===== build ======= - ============================

# target: build_storage - build storage image
.PHONY: build_storage
build_storage:
	@docker-compose \
		-p $(PROJECT) \
		-f build.yml \
		build storage


# target: build_migrator - build migrator image
.PHONY: build_migrator
build_migrator:
	@docker-compose \
		-p $(PROJECT) \
		-f build.yml \
		build migrator


# target: build_synchro - build synchro image
.PHONY: build_synchro
build_synchro:
	@docker-compose \
		-p $(PROJECT) \
		-f build.yml \
		build synchro				


# target: build_tester - build tester image for test api
.PHONY: build_tester
build_tester:
	@docker-compose \
		-p $(PROJECT) \
		-f build.yml \
		build tester		



# target: build_all - build all images in project
.PHONY: build_all
build_all:
	@echo "---> build storage"	
	@make build_storage

	@echo "---> build migrator"
	@make build_migrator

	@echo "---> build synchro"
	@make build_synchro

	@echo "---> build tester"
	@make build_tester




# target:
# target: ===== bootstrap === - ============================

# target: bootstrap_storage - bootstrap storage contaner
.PHONY: bootstrap_storage
bootstrap_storage:
	@echo "---> bootstrap storage contaner ..."
	@docker-compose \
		-p $(PROJECT) \
		-f bootstrap.yml \
		run -d storage
	@echo "	---> wait 30sec for settings mysql db ..."			
	@sleep 30
	@echo "		bootstraped"
	@echo "	---> stop & remove storage contaner ..."	
	@docker stop $(PROJECT)_storage_run_1
	@docker rm $(PROJECT)_storage_run_1
	@echo "		removed"


# target: bootstrap_migrator - bootstrap migrator contaner
.PHONY: bootstrap_migrator
bootstrap_migrator:
	@docker-compose \
		-p $(PROJECT) \
		-f bootstrap.yml \
		run --rm migrator /usr/local/bin/bootstrap.sh		


# target: bootstrap_synchro - bootstrap synchro contaner
.PHONY: bootstrap_synchro
bootstrap_synchro:
	@docker-compose \
		-p $(PROJECT) \
		-f bootstrap.yml \
		run --rm synchro /usr/local/bin/bootstrap.sh		


# target: bootstrap_tester - bootstrap tester contaner
.PHONY: bootstrap_tester
bootstrap_tester:
	@docker-compose \
		-p $(PROJECT) \
		-f bootstrap.yml \
		run --rm tester /usr/local/bin/bootstrap.sh				



# target: bootstrap_all - bootstrap all containers
.PHONY: bootstrap_all
bootstrap_all:
	@echo "---> bootstrap storage"	
	@make bootstrap_storage

	@echo "---> bootstrap migrator"
	@make bootstrap_migrator

	@echo "---> bootstrap synchro"
	@make bootstrap_synchro

	@echo "---> bootstrap tester"	
	@make bootstrap_tester		




# target:
# target: ===== db ========== - ============================

# target: db_up - run storage container
.PHONY: db_up
db_up:
	@docker-compose \
		-p $(PROJECT) \
		-f db.yml \
		up -d --no-build --no-recreate


# target: db_test - test storage container
.PHONY: db_test
db_test:
	@echo '===> test invoice ...'
	@echo "\s" | \
		mysql -h 127.0.0.1 -P 3306 -u invoice -p invoice
	@#...passinvoice


# target: db_load - load data to storage container
.PHONY: db_load
db_load:
	@echo '===> load invoice ...'
	@gunzip -c ../../data/invoice.gz | \
		mysql -h 127.0.0.1 -P 3306 -u invoice -p invoice
	@echo '      loaded'
	@#...passinvoice


# target: db_dump - dump data from storage container
.PHONY: db_dump
db_dump:
	@echo '===> dump invoice ...'
	@mysqldump -h 127.0.0.1 -P 3306 -u invoice -p invoice | gzip > ../../data/invoice.gz
	@echo '      dumped'
	@#...passinvoice



# target:
# target: ===== migrate ===== - ============================

# target: migrate_migrator - migrate migrator models
.PHONY: migrate_migrator
migrate_migrator:
	@docker-compose \
		-p $(PROJECT) \
		-f migrate.yml \
		run --rm migrator
	@make down



# target:
# target: ===== shell ======= - ============================


# target: shell_migrator - shell migrator container
.PHONY: shell_migrator
shell_migrator:
	@docker-compose \
		-p $(PROJECT) \
		-f run.yml \
		-f shell.yml \
		run \
		--rm \
		--service-ports \
		--name $(PROJECT)_migrator_1 \
		migrator \
		/bin/bash

# target: shell_synchro - shell synchro container
.PHONY: shell_synchro
shell_synchro:
	@docker-compose \
		-p $(PROJECT) \
		-f run.yml \
		-f shell.yml \
		run \
		--rm \
		--service-ports \
		--name $(PROJECT)_synchro_1 \
		synchro \
		/bin/bash

# target: shell_tester - shell tester container
.PHONY: shell_tester
shell_tester:
	@docker-compose \
		-p $(PROJECT) \
		-f run.yml \
		-f shell.yml \
		run \
		--rm \
		--name $(PROJECT)_tester_1 \
		tester \
		/bin/bash







# target:
# target: ===== misc ======== - ============================

# target: down - shutdown all contaner in project
.PHONY: down
down:
	@docker-compose \
		-p $(PROJECT) \
		-f run.yml \
		down	


# target: ps - watch all process all contaner in project
.PHONY: ps
ps:
	@docker-compose \
		-p $(PROJECT) \
		-f run.yml \
		ps

# target: clear - clear untuged images in project
.PHONY: clear
clear:
	@../../scripts/clear_untagged.sh


# target: images - show all images in project
.PHONY: images
images:
	@docker images |grep $(PROJECT)


# target: volumes - show all volumes in project
.PHONY: volumes
volumes:
	@docker volume ls |grep $(PROJECT)


# target: rmi - remove all images in project
.PHONY: rmi
rmi:
	@docker rmi `docker images |grep $(PROJECT) |xargs -L1 | awk '{print $1}'`


# target: rmvol - remove all volumes in project
.PHONY: rmvol
rmvol:
	@docker volume rm `docker volume ls |grep $(PROJECT) |xargs -L1 | awk "{print $2}"`
# ...
# docker images |grep tsfersf |xargs -L1 | awk '{print $1}'
# docker images |grep tsfersf

# ...
# docker volume ls |grep tsfersf |xargs -L1 | awk '{print $2}'
# docker volume rm $(docker volume ls |grep tsfersf |xargs -L1 | awk '{print $2}')





