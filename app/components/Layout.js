import React, { PropTypes, Component } from 'react';
import HeaderBar from './HeaderBar';

/**
 * Layout header
 * 
 * @export
 * @class Header
 * @extends {Component}
 */
export class Header extends Component {

  /**
   * @type {HeaderBar.Style}
   * @static
   * @memberOf Header
   */
  static Style = HeaderBar.Style;

  /**
   * @override
   */
  render() {
    return (
      <div className="layout__header">
        <HeaderBar { ...this.props } />
      </div>
    );
  }
}

/**
 * Content container
 * 
 * @export
 * @class Container
 * @extends {Component}
 */
export class Container extends Component {

  /**
   * PropTypes
   * @static
   * @memberOf Container
   */
  static propTypes = {
    children: PropTypes.element.isRequired
  };

  /**
   * @override
   */
  render() {
    return (
      <div className="layout__container">
        { this.props.children }
      </div>
    );
  }
}

/**
 * Layout container
 * 
 * @export
 * @class Layout
 * @extends {Component}
 */
export class Layout extends Component {

  /**
   * PropTypes
   * @static
   * @memberOf Container
   */
  static propTypes = {
    children: PropTypes.oneOfType([
      PropTypes.arrayOf(PropTypes.element),
      PropTypes.element,
    ])
  };
  
  /**
   * @override
   */
  render() {
    return (
      <div className="layout">
        { this.props.children }
      </div>
    );
  }
}
