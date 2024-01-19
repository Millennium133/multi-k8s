docker build -t millennium133/multi-client:latest -t millennium133/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t millennium133/multi-server:latest -t millennium133/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t millennium133/multi-worker:latest -t millennium133/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push millennium133/multi-client:latest 
docker push millennium133/multi-server:latest
docker push millennium133/multi-worker:latest

docker push millennium133/multi-client:$SHA 
docker push millennium133/multi-server:$SHA
docker push millennium133/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=millennium133/multi-server:$SHA
kubectl set image deployments/client-deployment client=millennium133/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=millennium133/multi-worker:$SHA
