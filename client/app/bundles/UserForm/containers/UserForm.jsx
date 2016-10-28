import React, { PropTypes } from 'react';
import UserFormWidget from '../components/UserFormWidget';

export default class UserForm extends React.Component {
  render() {
    return(
      <UserFormWidget {...this.props} />
    );
  }
}
