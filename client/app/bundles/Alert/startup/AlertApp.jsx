import React, { PropTypes } from 'react';
import ReactOnRails from 'react-on-rails';
import Alert from '../containers/Alert';

const AlertApp = (props) => (
  <Alert {...props} />
);

ReactOnRails.register({ AlertApp });
