# Vagrant support
```
cd vagrant
vagrant up
```

When finished, use a HTTP/REST client like Postman to verify the fingerprint and recorgnize endpoints :
```
curl -F ‘data=@dejavu/mp3/Brad-Sucks--Total-Breakdown.mp3’ http://localhost:8080/fingerprint

# Fingerprint require few minutes to finish
curl -F ‘data=@dejavu/mp3/Brad-Sucks--Total-Breakdown-trimmed.mp3’ http://localhost:8080/recorgnize
```
