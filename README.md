webrockit-api
==========

The webrockit-api allows users to add/remove/list checks within the WebRockKit system. This system uses riak as the storage for check objects. Check objects are fetched from riak using the sensu-riak-sync application and placed onto disk for sensu to load.

**Building:**

1. Use jruby
2. Run "`bundle install`" from within this repo. You may have to install bundler ("`gem install bundler`")
3. Build running `jruby -S warble`

**Running:**

1. Copy "config/config.yml.example" to "config/config.yml" and edit settings.
2. Config is also fetched out of "/opt/webrockit-api/config/config.yml"
`java -jar webrockit-api.jar config/web.ru -p 8081`

**Install:**

1. `cd /opt`
2. git clone this repo
3. `sh ext/install.sh`

**Testing:**

1. Update the config_helper.rb to point to a local riak.
2. Set api basic_auth user and pass to 'admin'
3. Run the tests `rspec`

**Use:**

Need to create a type first. Types are high level organizational units used throughout Webrockit. After that you can create a poller, or go right to the checks if you dont mind using the default.

##### Create a type
`GET http://127.0.0.1:8081/v1/createType?type=sometype1&description=This is a type`

##### List the check types
`GET http://127.0.0.1:8081/v1/listTypes`

##### Fetch type info
`GET http://127.0.0.1:8081/v1/fetchType?type=sometype1`

##### Delete a check type
`GET http://127.0.0.1:8081/v1/deleteType?type=sometype1`


Need to create pollers next. Pollers are sensu tags the server uses to subscibe to a check. Default poller for checks is 'webpoller' if one isnt provided

##### Create a poller
`GET http://127.0.0.1:8081/v1/createPoller?poller=somepoller1&description=This is a poller`

##### List the check pollers
`GET http://127.0.0.1:8081/v1/listPollers`

##### Fetch poller info
`GET http://127.0.0.1:8081/v1/fetchPoller?poller=somepoller1`

##### Delete a check poller
`GET http://127.0.0.1:8081/v1/deletePoller?poller=somepoller1`

Create Checks. Note: Its important for the user/application to have some context of what the check name would look like. Check names are basically your graphite prefix. Naming the check is important for being able to properly navigate to your metric later.

##### Create/update a check:
`GET http://127.0.0.1:8081/v1/createCheck?type=sometype1&name=hosting.sometype1.blah.blah&interval=300&application=wordpress&url=http://something&ipaddress=1.2.3.4`

##### List checks by type:
`GET http://127.0.0.1:8081/v1/listChecks?type=sometype1`

##### Fetch check info
`GET http://127.0.0.1:8081/v1/fetchCheck?type=sometype1&name=hosting.sometype1.blah.blah`

##### Delete a check:
`GET http://127.0.0.1:8081/v1/deleteCheck?type=sometype1&name=hosting.sometype1.blah.blah`

### License
   webrockit-api is released under the MIT license, and bundles other liberally licensed OSS components [License](LICENSE.txt)  
   [Third Party Software](third-party.txt)
