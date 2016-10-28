import React, { PropTypes } from 'react';
import SearchFormWidget from '../components/SearchFormWidget';

export default class SearchForm extends React.Component {
  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <SearchFormWidget {...this.props} />
    );
  }
}
