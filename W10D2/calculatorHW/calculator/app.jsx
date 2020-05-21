import React from 'react';
import ReactDOM from 'react-dom';
//import Congrats from './congrats';
import Clock from './frontend/clock.jsx';

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  ReactDOM.render(<Calculator/>, document.getElementById('root'));
});
