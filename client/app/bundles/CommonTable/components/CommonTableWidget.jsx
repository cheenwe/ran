import React, { PropTypes } from 'react';
import { Table } from 'antd';

export default class CommonTableWidget extends React.Component {
  pagination() {
    const pagination = {
      total: this.props.total,
      defaultPageSize: this.props.page_size,
      current: this.props.current,
      showSizeChanger: false,
      onShowSizeChange(current, pageSize) {
        //console.log("Current: ", current, ", pageSize: ", pageSize);
      },
      onChange(current) {
        //console.log("Change, current: ", current);
        window.location = "?page=" + current;
      }
    };
    return pagination;
  }
  render() {
    var columns = [];
    var operation = {
      title: '操作',
      key: 'operation',
      render: (text, record) => (
        <span>
          <a href={"/" + this.props.type + "/" + record.id + "/edit"}>编辑</a>
          <span className="ant-divider"></span>
          <a href={"/" + this.props.type + "/" + record.id} data-method="delete" data-confirm="你确定?">删除</a>
        </span>
      )
    };
    for (var i in this.props.columnNames) {
      let col = {
        title: this.props.columnNames[i],
        dataIndex: i,
        key: i
      }
      columns.push(col);
    }
    columns.push(operation);
    return(
      <Table dataSource={this.props.dataSource} columns={columns} pagination={this.pagination()}></Table>
    );
  }
}
