import React from "react"
import PropTypes from "prop-types"
class UserTr extends React.Component {
  render () {
    return (
        <tr>
          <td>{this.props.email}</td>
          <td>{this.props.username}</td>
          <td>{this.props.password_digest}</td>
        </tr>
    );
  }
}

UserTr.propTypes = {
  email: PropTypes.string,
  username: PropTypes.string,
  passwordDigest: PropTypes.string
};
export default UserTr
