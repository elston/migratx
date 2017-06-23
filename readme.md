migratx
========================

Technology
----------------
- Docker
- Python 2.7
- Twisted
- MySql 5.7
- Virtualenv


Getting Started with Docker and Docker Compose for Local Development
--------------------------------------------------------------------

### Install Docker

https://docs.docker.com/installation/

### Install Docker Compose

http://docs.docker.com/compose/install/

### Install the app's

In the project ./book/dev/ (where the `Makefile` file is located), run:

```
make build_all
```

then

```
make bootstrap_all
```

then

```
make db_run
```

then test db

```
make db_test
```

if all OK, down db

```
make down
```

then migrate db

```
make migrate_all
```

To run any command inside the Django Docker container, simply prepend:

```
make shell_synchro
```
This will start the containers in the debug mode.


When you need finish all containers:

```
make down
```


### View the images

```
make images
```

### View the volumes

```
make volumes
```

### Clear untagged Docker containers

```
make clear
```

### To view runing Docker containers

```
make ps
```


hand made migrations on db
--------------------------------------------------------------------

first

```
make shell_migrator
workon migrator
cd /migrator
```

Next

1.

```
./manage.py db init   
```

2.

```
./manage.py db revision --autogenerate -m "initial"
```

3.

```
./manage.py db upgrade
```

4.

```
./manage.py db downgrade
```

Helper for command:

```
positional arguments:
  {shell,db,runserver}
    shell               Runs a Python shell inside Flask application context.
    db                  Perform database migrations
    runserver           Runs the Flask development server i.e. app.run()


positional arguments:
  {upgrade,heads,merge,migrate,stamp,show,current,edit,init,downgrade,branches,history,revision}
    upgrade             Upgrade to a later version
    heads               Show current available heads in the script directory
    merge               Merge two revisions together. Creates a new migration
                        file
    migrate             Alias for 'revision --autogenerate'
    stamp               'stamp' the revision table with the given revision;
                        don't run any migrations
    show                Show the revision denoted by the given symbol.
    current             Display the current revision for each database.
    edit                Edit current revision.
    init                Creates a new migration repository
    downgrade           Revert to a previous version
    branches            Show current branch points
    history             List changeset scripts in chronological order.
    revision            Create a new revision file.

```