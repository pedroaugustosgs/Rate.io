const { getDataConnect, validateArgs } = require('firebase/data-connect');

const connectorConfig = {
  connector: 'default',
  service: 'Rate.io',
  location: 'us-central1'
};
exports.connectorConfig = connectorConfig;

