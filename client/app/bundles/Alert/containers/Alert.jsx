import React, { PropTypes } from 'react';
import AlertWidget from '../components/AlertWidget';

export default class Alert extends React.Component {
  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <AlertWidget {...this.props} />
    );
  }
}
