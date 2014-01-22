module SchemaHelper
  def self.showInitial(requestObject)
    data = {
      'type'  => 'collection',
      'links' => {
        'self' => "#{requestObject.url}",
        'schemas' => "#{requestObject.url}schemas" },
      'data' => [
        'id' => 'v1',
        'type' => 'api_version',
        'links' => {
          'self' => "#{requestObject.url}v1",
          'schemas' => "#{requestObject.url}schemas"
        }
      ]
    }.to_json
    return data
  end

  def self.showSchemas(requestObject)
    data = {
      'type'  => 'collection',
      'links' => {'self' => "#{requestObject.url}"},
      'data'  => [{
          'id'              => 'createCheck',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/createCheck"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'name'        => { 'type' => 'string', 'required' => true },
            'url'         => { 'type' => 'string', 'required' => true },
            'type'        => { 'type' => 'string', 'required' => true },
            'application' => { 'type' => 'string', 'required' => true },
            'interval'    => { 'type' => 'int',    'required' => true },
            'ipaddress'   => { 'type' => 'string'},
            'poller'      => { 'type' => 'string'},
          }
        },{
          'id'              => 'listChecks',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/listChecks"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'type' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'fetchCheck',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/fetchCheck"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'name' => { 'type' => 'string', 'required' => true },
            'type' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'deleteCheck',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/deleteCheck"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'name' => { 'type' => 'string', 'required' => true },
            'type' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'createType',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/createType"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'type'        => { 'type' => 'string', 'required' => true },
            'description' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'listTypes',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/listTypes"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => {}
        },{
          'id'              => 'fetchType',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/fetchType"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'type' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'deleteType',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/deleteType"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'type' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'createPoller',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/createPoller"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'poller'        => { 'type' => 'string', 'required' => true },
            'description'   => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'deletePoller',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/deletePoller"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'poller' => { 'type' => 'string', 'required' => true },
          }
        },{
          'id'              => 'listPollers',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/listPollers"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => {}
        },{
          'id'              => 'fetchPoller',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/fetchPoller"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'poller' => { 'type' => 'string', 'required' => true },
          }
        }]
    }.to_json
    return data
  end

  def self.schemaDetails(method,schemaObject)
  end
end