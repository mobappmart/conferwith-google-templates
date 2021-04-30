___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Conferwith Tracking",
  "categories": [
    "ATTRIBUTION"
  ],
  "brand": {
    "id": "brand_dummy",
    "displayName": "ConferWith"
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "eventType",
    "displayName": "Event Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "startCall",
        "displayValue": "Start Call"
      },
      {
        "value": "addToBasket",
        "displayValue": "Add to Basket"
      },
      {
        "value": "share",
        "displayValue": "Share"
      },
      {
        "value": "checkout",
        "displayValue": "Checkout"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "startCall",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const callInWindow = require('callInWindow');
const copyFromWindow = require('copyFromWindow');
const log = require('logToConsole');
const setInWindow = require('setInWindow');
const injectScript = require('injectScript');
const dataLayer = require('copyFromDataLayer');
const localStorage = require('localStorage');

const sendRequest = copyFromWindow('sendRequest');

const sessionId =  dataLayer('sessionId');
const products = dataLayer('products');
const eventType = dataLayer('eventType');
const store = dataLayer('store');
const product = dataLayer('product');
const actor = dataLayer('actor');
const serverUrl = localStorage.getItem('serverUrl');
const checkoutId =  dataLayer('checkoutId');
const action =  dataLayer('action');
const label = dataLayer('label');
const logData = dataLayer('data');
const description = dataLayer('description');

const trackObject = (function() {
  if(eventType == 'checkout'){
    return {        
        store: store,
        sessionId: sessionId,
        checkoutId:checkoutId,
        products: products,
        trackingFrom: 'GTM'
      };
  } else 
      return {
        action: action,  
        label: 'GTM_'+ label,
        store: store,
        sessionId: sessionId,
        actor: actor,
        description: description,
        data: data
      };
  } 
)();

log('data:', trackObject);
log('serverUrl:', serverUrl);

const onSuccess = () => {
  log('Script loaded successfully.');

if (trackObject) {
  if(eventType == 'checkout') {
    callInWindow('sendRequest', serverUrl+'/api/checkout', trackObject);
  } else {
    callInWindow('sendRequest', serverUrl+'/api/activity', trackObject);
  }
  
}
  
  data.gtmOnSuccess();
};

// If the script fails to load, log a message and signal failure
const onFailure = () => {
  log('Script load failed.');
  data.gtmOnFailure();
};

injectScript('https://instore-expert-dev.site/public/videos/postReq.js', onSuccess, onFailure);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "sendRequest"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://instore-expert-dev.site/public/videos/postReq.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "sessionId"
              },
              {
                "type": 1,
                "string": "products"
              },
              {
                "type": 1,
                "string": "eventType"
              },
              {
                "type": 1,
                "string": "store"
              },
              {
                "type": 1,
                "string": "product"
              },
              {
                "type": 1,
                "string": "actor"
              },
              {
                "type": 1,
                "string": "serverUrl"
              },
              {
                "type": 1,
                "string": "checkoutId"
              },
              {
                "type": 1,
                "string": "action"
              },
              {
                "type": 1,
                "string": "label"
              },
              {
                "type": 1,
                "string": "data"
              },
              {
                "type": 1,
                "string": "description"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "serverUrl"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 27/03/2020, 11:11:48


