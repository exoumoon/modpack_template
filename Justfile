# List available recipes.
default:
    @just --list

# Refresh `packwiz` and `git` index.
refresh:
    packwiz refresh
    git add .
    git status

# Start the server container.
start:
    docker compose up --detach --build
    docker compose logs --follow

# Stop the server container.
stop:
    docker compose down

# Restart the server container.
restart: stop start

# Make a full backup of the server.
[no-cd]
backup:
    #!/usr/bin/env nu
    let server_name = (pwd | path basename)
    let backup_name = $server_name + $"_(date now | format date '%Y-%m-%d_%H:%M:%S')"
    cd ..
    cp --recursive $server_name $".backups/($backup_name)"
    sync
    dua .backups
