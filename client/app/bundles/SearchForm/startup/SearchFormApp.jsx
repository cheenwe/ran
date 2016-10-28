import React, { PropTypes } from 'react';
import ReactOnRails from 'react-on-rails';
import SearchForm from '../containers/SearchForm';

const SearchFormApp = (props) => (
  <SearchForm {...props} />
);

ReactOnRails.register({ SearchFormApp });
