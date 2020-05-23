### Docker

Why use docker?
Story about installing a software.
What do we do to do that?
- Download software installer
- Run installer
- Encounter error
- Troubleshoot error
- Re-run installer
- Found anohter error
- That cycles reptes till installation complete

This is what docker might be expecting to solve. Make it easier to install a software.

Example:
redis - in-memory data structure store, used as a database, cache and message broker

If we go to the official page to instal the program, we found that it tells us to run a command that starts with wget [command]
As soon as we run that command, an error is showed: wget command not found (first problem, environment is not set to install redis just like that)

So te answer is that it makes it very easieer to install and run a software without worrying about environment, setup, etc.

What is docker?
Docker ecosystem:
- docker client
- docker server
- docker machine
- docker images
- docker hub
- docker compose

This all creates the docker ecosystem or platform usefull to run and install diferent containers

When isntalling redis with docker, running through a specific command, docker cli will go to docker hub and download a specific file, called an image and will will be saved in your hard drive, 
An image is a single file that keeps tracked of all config and setup for running a specific programm
A container is an instance of an image

When downloading docker, we are donwloading two difrerent modules

Docker client (AKA the cli): Module which is used to interact with as user (send commands)
Docker server (AKA docker daemon): The module that actually process those commands and knows what to do

## Cheatsheet

### $ docker version
// Output: client and server modules information

### $ docker run hello-world
// Output:
/*
  Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete                                                                                             Digest: sha256:6a65f928fb91fcfbc963f7aa6d57c8eeb426ad9a20c7ee045538ef34847f44f1
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
 */

Important: 1,2,3,4 steps that docker did when running the command

When running the command, we interact with the client which communicates with the server that will be in charge of the heavy part.
The server (docker daemon) will try to get the image hello-world inside an image cache container, inside our computer.
As it can not find it the first time, it will warning us that was "Unable to find image 'hello-world:latest' locally" so, following the output,
it will go to the hub and tell as that the image is being broguht from there "latest: Pulling from library/hello-world"
DOcker hub is the container (not container as docker definition but something that contains things) for every kind of images.

 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|                                           |
|  Terminal    NodeJS    Spotify    Chrome  |   // System programs running
|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        |              |              |
        |              |              |
        |              |              |
        V              V              V
  System call    System call    System call     // Programms request to kernel to access and interact with some piece of hardware
                       |
                       |
                       |
                       V
 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|                                           |
|                   KERNEL                  |   // System programs running
|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        |              |              |
        |              |              |
        |              |              |
        V              V              V
       CPU          Memory        Hard disk

System calls are like functions that calls certain endpoints given by kernel to access those pieces in particular


Namepsacing: (only on linux os)
task to isolate resources per process or group of process:
Assume that chomr and node.js, two running programms, use python V2 and python V3. Both programm will make a system call and through the namespacing, we can isolate those two pieces in the harddrive, python v2 and v3 to give acces (by the kernel) to both programms

Control group: (only on linux os)
Limit resources used per user. i.e.: band width, processing power, etc.

namespacing and control groups are techs for isolating and associating resources to processes, and they do not exist in every OS. Only in linux.

When we install docker for windows/macos we install a linux virtual machine where all this containers are going to be created and gonna use linux kernel inside that virtual machine. Inside that kernel is the one who will be hosting those process /containers with technies of namespacing and control groups with it's own

So with containers we esentially are creating not a physical container that exist inside our computer but instead a process/+1 processes that exist in our omputer that has an amount of resources assign to it/them

An image:
 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|                                     |
|                IMAGE                |
|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
|                  |                  |
|   FS snapshot    |  Startup command |
|_ _ _ _ _ _ _ _ _ | _ _ _ _ _ _ _ _ _|
|                  |                  |
| CHROME PYTHON    |  > Run chrome    |
|_ _ _ _ _ _ _ _ _ | _ _ _ _ _ _ _ _ _|

Diagram of a container
 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|     _ _ _ _ _ _ _ _                     |
|    |                |                   |
|    |     Chrome     |                   |  // "We" create an isntance of that chrome process from chrome below
|    |_ _ _ _ _ _ _ _ |                   |
|            |                            |
|            |                            |
|            V                            |
|      System call                        |
|            |                            |
|            |                            |
|            V                            |
|     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ | _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|    |                                    |                                                   |
|    |                   KERNEL           |                                                   |
|    |_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ | _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ |
|      |     |    |         |             |
|      |     |    |         |             |
|      |     |    |         |             |
|      V     |    V         V             |
|    CPU     |   RAM     Network          |
|            |                            |
|     _ _ _ _V_ _ _ _ _                   |
|    |                  |                 |
|    |  CHROME - PYTHON |                 |   // This is the part of docker create (copy all filesystem needed to run container)
|    |_ _ _ _ _ _ _ _ _ |                 |   // Docker start will effectively run the command in the image
|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|

Container lifecycle
### $ docker run = $ docker create + $ docker start

When a container is stopped, it can be run again but default command used the first time it run can not be override.

(*redis)
redis-servers instantiate a database-like conenctions and we can interact with it with another module called redis-cli
Wen we install redis-server as a docker container, docker run redis-server, we can not access redis-cli from outside the container
This is the reason for which we whould want to run ANOTHER command inside that container with the $ docker exec -it {dockerId} redis-cli

(*redis-it-flag)
All containers have 3 communication channels STDIN STDOUT STDERR (Standar in, standar out, standar error)
They are useful to recevei or give information (through or to owr temrinal)
-it === -i -t
The -i gives the posibility to give some text after running the command specified.
The -t gives, formatting-ish styles, more or less.

Dockerfile
WHen creating a dockerfile, we should create a file called `Dockerfile`
This will have instructions such as
FOR baseImage
COPY ./from ./to
RUN commandToRun
CMD ["npm", "start"]

The base image should be one that has the software needed to run what we will be running on the RUN instruction.
The cmd is the command that the container will run once the container is run.



Cheatsheet

### $ docker version
// Output: client and server modules information

### $ docker run hello-world
// Output:
/*

Overriding default commands once a container is up

### $ docker run image [overrideCommand]
### $ docker run busybox ls

//Output:
/*

 */
This will print (in macos, dir for windows) the list of directories / folders that the container has.
When we run that container, the kernel creates a copy of all the hardrive needed to run the process
In our case, we are overriding the process with the process ls/dir to see over directories. When lsiting those folders we can see a .bin folder that has the ls command integrate.
This is not enable in an image like hello-world because it does not copy the files needed to run the command ls (or echo)
(
   same container of CHROME and python above, and instead of CHROME and python, we have these folders copy pasted in our hardDrive inside the container:
      -bin
      -dev
      -etc
      -home
      -proc
      -root
      -sys
      -tmp
      -usr
      -var
)

### $ docker ps
// Output: List containers running

### $ docker ps --all
// Output: List all containers that run in a point in time in the pase

### $ docker create {dockerName}

### $ docker start [-a] {dockerId}
// Run the container.
// -a : watch the container for any output and print it out to the terminal, every output.

### $ docker system prune
// Output: Delete not only stopped containers but also other things like network resources not used or images in our build cache

### $ docker logs {dockerId}
// Output: watch the output that the container gave when run. This logs command does not re-run the container, only watches output

Assuming we run the $ docker run busybox ping google.com, we never stopped it, it ketp pinging google.com, docker logs {dockerId} will show every printed latency to google.com

### $ docker stop {containerId}
### $ docker kill {containerId}
// Stop or kill a process. They both send a stop or kill signal (SIGNTERM / SIGNKILL). The stop will tell the container its process in  due time, while the kill process ordered to STOP and KILLED the process right now.

### $ docker exec -it {dockerId} {command}
// See (*redis) -
// See (*redis-it-flag)

### $ docker exec -it {dockerId} sh
// The sh means a particular command processor - terminal - (bash, powershell, zsh, sh)
// Only dockerId, no tag alias

### $ docker run -it busybox sh
// We can also start a container and at the same time exec another command related to that programm. As well as give the -i and -t flags

### $ docker build .
// This command will build our image . We have to be inside the directory where the dockerfile is

### $ docker build -t stefanofrontani/simple-web .
// That will build the container with the alias, so we dont have to call the id every time
### $ docker run stefanofrontani/simple-web

### $ docker run -p portFromSourceMachine:containerPort stefanofrontani/simple-web