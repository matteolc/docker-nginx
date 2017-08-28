#!/bin/bash

# Copyright 2017 Voxbox.io
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STACK_NAME=api
echo "---------------------------------------------------------------------"
echo "Cleaning up"
echo "---------------------------------------------------------------------"
$DIR/cleanup.sh
echo "---------------------------------------------------------------------"
echo "Initializing Swarm"
echo "---------------------------------------------------------------------"
docker swarm init
echo "---------------------------------------------------------------------"
echo "Nodes in the swarm:"
echo "---------------------------------------------------------------------"
docker node ls
echo "---------------------------------------------------------------------"
echo "Deploying the stack to the swarm"
echo "---------------------------------------------------------------------"
docker stack deploy -c docker-compose.yml $STACK_NAME
echo "---------------------------------------------------------------------"
echo "Stack status:"
echo "---------------------------------------------------------------------"
docker stack ls
docker stack ps $STACK_NAME
echo "---------------------------------------------------------------------"
echo "Waiting until Postresql is up"
echo "---------------------------------------------------------------------"
$DIR/wait-for-postgres.sh
echo "---------------------------------------------------------------------"
echo "Waiting until Puma is up"
echo "---------------------------------------------------------------------"
$DIR/wait-for-puma.sh
RAILS_CONTAINER=$(docker ps -qf name=app)
docker exec -it ${RAILS_CONTAINER} bundle exec rake db:migrate
docker service logs ${STACK_NAME}_app -f
