import React, { PropTypes } from 'react';
import LoginFormWidget from '../components/LoginFormWidget';

export default class LoginForm extends React.Component {
  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <LoginFormWidget {...this.props} />
    );
  }
}
