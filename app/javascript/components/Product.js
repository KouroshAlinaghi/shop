import React from "react"
import PropTypes from "prop-types"
class Product extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div className="card" style={{width: "28rem"}} >
          <img src={this.props.imageSource} className="card-img-top"/>
          <div classNmae="card-body">
            <h5 className="card-title">{this.props.name}</h5>
            <h6 className="card-subtitle mb-2 text-muted">{this.props.categoryTitle}</h6>
            <p className="card-text">{this.props.description}</p>
            Price: {this.props.price}$<br />
            Status: {this.props.statusToString}<br />
          </div>
        </div>
      </React.Fragment>
    );
  }
}

Product.propTypes = {
  imageSource: PropTypes.string,
  name: PropTypes.string,
  categoryTitle: PropTypes.string,
  price: PropTypes.node,
  statusToString: PropTypes.string,
  description: PropTypes.string
};
export default Product
