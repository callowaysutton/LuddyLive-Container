import os
import sys

# INPUT: Username and Password
# Output: Running Docker container, Reverse Proxy pointing to it

# Build the docker container for the particular user
# docker build -t container . --build-arg USER={USERNAME} --build-arg PASS={PASSWORD}
def build_container(username, password):
    DOCKER_BUILD = f"docker build -t container . --build-arg USER={user} --build-arg PASS={password}"
    pass
    
# Run the Docker container
# docker run --runtime=sysbox-runc --name {NAME} -d -h {NAME}.luddy.live --mount type=bind,source=/var/run/utmp,target=/var/run/utmp container
def run_container():
    pass
    
# TODO: Add Docker container to reverse proxy
def add_proxy():
    pass

if __name__ == "__main__":
    print(sys.argv)
    username = sys.argv[1]
    password = sys.argv[2]
    print(f"Adding a user with the username: {username}")
