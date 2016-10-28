import React from 'react';
import classNames from 'classnames';
import { Form, Input, Button } from 'antd';
const InputGroup = Input.Group;

export default class SearchFormWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: this.props.default || '',
      focus: false
    }
  }

  render() {
    const { style, size, placeholder } = this.props;
    const btnCls = classNames({
      'ant-search-btn': true,
      'ant-search-btn-noempty': !!this.state.value.trim()
    });
    const searchCls = classNames({
      'ant-search-input': true,
      'ant-search-input-focus': this.state.foucs
    });
    return (
      <Form horizontal style={this.props.style} action={this.props.action} method="GET" onSubmit={() => {}}>
        <Form.Item>
            <InputGroup className={searchCls}>
              <Input name="q" placeholder={placeholder} defaultValue={this.state.value}></Input>
              <div className="ant-input-group-wrap">
                <Button type="primary" htmlType="submit" icon="search" className={btnCls} size={size}></Button>
              </div>
            </InputGroup>
        </Form.Item>
      </Form>
    )
  }
}
