import React, { PropTypes } from 'react';
import ReactOnRails from 'react-on-rails';
import LoginForm from '../containers/LoginForm';

const LoginFormApp = (props) => (
  <LoginForm {...props} />
);

ReactOnRails.register({ LoginFormApp });
