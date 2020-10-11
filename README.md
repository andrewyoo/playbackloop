# README

PlaybackLoop was a site that accesses playlists and allows re-sorting playlists in various order. Most notably useful was to sort by created at date to view playlists in chronological order.

## Last Update
PlaybackLoop is down :(

On September 28th, Youtube started erroring saying that PBL is over it's quota. Without warning the quota was set to 0, so PBL is always over quota now. I don't know why Youtube did this all of a sudden without warning.

In the past, I have requested higher quota limits, but have been denied with the following answer

Policy I.1 (Additional Prohibitions)
I will try to bring back PBL, but unfortunately it's very hard for a small developer with a hobby site to get any response from Google. Sorry to everyone that has come to PBL and expected continual service.

Anyway we've had a good run and thanks for everyone who has reached out to me. I wish I could promise this site will be fixed, but given this site relied upon youtube and they have blocked PBL, it's not looking great.

PlaybackLoop 2017 - 2020

## Public
* I have made this repo public for others to play with. Technically if this site should work as of 9/2020 if you had a valid youtube api key.

## Installing

This is a pretty standard Ruby on Rails app. There is a encrypted credentials file in /config. This file has the following format:

```
secret_key_base: xxxxxxxx

errors_email: info@playbackloop.com
sender_email: info@playbackloop.com

opsworks:
  production:
    stack_id: xxxxx
    app_id: xxxxx

development: &default
  google:
    api_key: xxxxx
    client_id: xxxxx
    secret: xxxxx
  aws:
    access_key: xxxxx
    secret_key: xxxxx
    region: us-east-1

test:
  <<: *default

production:
  <<: *default
  google:
    api_key: xxxxx
    client_id: xxxxx
    secret: xxxxx
  aws:
    access_key: xxxxx
    secret_key: xxxxx
    region: us-east-1
 ```
 The `opsworks` related keys were for deploying via `opsworks` which is an AWS service that uses `chef`.  You can modify to deploy as you like.
 
### Things that might be useful to install on mac.
* use `rbenv`
* `gem install libv8 -v '3.16.14.19' -- --with-system-v8`
* `gem install therubyracer -v '0.12.3' -- --with-v8-dir=/usr/local/opt/v8@3.15`
