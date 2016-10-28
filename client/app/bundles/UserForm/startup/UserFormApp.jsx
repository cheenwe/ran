import React, { PropTypes } from 'react';
import ReactOnRails from 'react-on-rails';
import UserForm from '../containers/UserForm';

const UserFormApp = (props) => (
  <UserForm {...props}></UserForm>
);

ReactOnRails.register({ UserFormApp });
