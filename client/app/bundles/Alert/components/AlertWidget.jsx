import React, { PropTypes } from 'react';
import { Alert } from 'antd';


export default class AlertWidget extends React.Component {

   onClose (e) {
    console.log(e, 'I was closed.');
  };

  render() {
    return (
      <div style={{padding: 10}}
          onClick={this.onClose}>

        <Alert message={this.props.message}
          description={this.props.description}
          type={this.props.type}
          closeText="Close Now"

          showIcon
        />
      </div>
    );
  }
}
