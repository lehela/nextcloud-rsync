echo "Build lehela/goocloud-rsync-user image for..."

read -p 'Goocloud User: ' user
read -p 'Password: ' password
# read -p 'Path to sync: ' hostpath
# read -p 'Container Name: ' containername

export user=$user \
    password=$password 

# Create the initial container
docker build --build-arg user=${user} --build-arg password=${password} --tag lehela/goocloud-rsync-${user}:latest .

