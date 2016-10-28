import React from 'react';
import ReactOnRails from 'react-on-rails';
import CommonTable from '../containers/CommonTable';

const CommonTableApp = (props) => (
  <CommonTable {...props}></CommonTable>
);

ReactOnRails.register({ CommonTableApp });
