import React, { PropTypes } from 'react';
import { Button, Form, Input, Checkbox, Tooltip, Icon, Row, Col} from 'antd';

const createForm = Form.create;
const FormItem = Form.Item;

function noop() {
	return false;
}

export default class LoginFormWidget extends React.Component {

	handleSubmit(e) {
		console.log('submit login');
	}
	render() {

		const formItemLayout = {
			labelCol: { span: 3 },
			wrapperCol: { span: 7 },
		};
		const formStyle = {
			marginTop: 100,
			paddingTop: 24,
			paddingLeft: 8,
			//paddingBottom: 16,
			paddingRight: 8,
			borderRadius: 6
		};
		return (
			<Row className="" type="flex" justify="space-around" align="middle">
        		<Col span="10">


				<Form horizontal  action="/account/sign_in" method="POST" onSubmit={this.handleSubmit}
					style={formStyle}>

					<h2>Log in</h2>

					<Input name="authenticity_token" type="hidden" value={this.props.csrf_token} />

					<FormItem
						{...formItemLayout}
						label="Email"
						hasFeedback
						>
						<Input placeholder="请输入用户名" name="user[email]" />
					</FormItem>

					<FormItem
						{...formItemLayout}
						label="密码">
						<Input type='password' name="user[password]" placeholder='请输入密码' />
					</FormItem>

					<FormItem
						{...formItemLayout}
						>
						<Checkbox name="user[remember_me]">记住密码</Checkbox>
					</FormItem>

					<FormItem
						{...formItemLayout}
						>
						<Button type="primary" htmlType="submit">登录</Button>
					</FormItem>

				</Form>
			</Col>
			</Row>
		);
	}
}
