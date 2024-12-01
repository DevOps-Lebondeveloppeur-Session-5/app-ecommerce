// index.test.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './app';

jest.mock('react-dom', () => ({ render: jest.fn() }));

describe('index.js', () => {
  test('renders the App component without crashing', () => {
    // Import the index file
    require('./index');

    // Check if ReactDOM.render was called with <App /> and the correct element
    expect(ReactDOM.render).toHaveBeenCalledWith(<App />, document.getElementById('root'));
  });
});
