import React, { PropTypes } from 'react';
import CommonTableWidget from '../components/CommonTableWidget';

export default class CommonTable extends React.Component {
  constructor(props, context) {
    super(props, context);
  }
  render() {
    return (
      <CommonTableWidget {...this.props}></CommonTableWidget>
    )
  }
}
