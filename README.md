# Docker environment for kobuki
ROS 2 humble docker environment for the kobuki base.

Based on the [packages build using docker as well](https://github.com/helloric/docker-kobuki-compile/)

## Usage
Just install docker-ce on your machine and pull the docker image.
Afterwards run the docker environment on your machine, thats easiest with docker compose, just run `docker compose up -d kobuki-base-arm64`.
You could also setup systemd to automatically start the image, however you probably want to use this project as base and create your own docker-compose file.

Don't forget to set your `ROS_DOMAIN_ID` in the docker-compose file or by providing a `.env`-file that has the `ROS_DOMAIN_ID` set

After starting the docker environment on your robot you should hear the sound of the kobuki base.
Now you can control your robot on from your PC by running `ros2 run rqt_robot_steering rqt_robot_steering` and setting the topic to `/command/velocity`
![Screenshot of rqt_robot_steering with corect topic](https://github.com/user-attachments/assets/931b414c-93fc-4f22-bd5f-802e14e28659)

It's recommended to start by moving slowly on the spot instead of moving forward/backward right away.
