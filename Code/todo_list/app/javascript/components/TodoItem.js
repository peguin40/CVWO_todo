import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
import "materialize-css/dist/js/materialize"

class TodoItem extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      id: this.props.id,
      description: this.props.description,
      completed: this.props.completed,
      categories: this.props.categories,
      showing: true,
      edit_link: '/task/'+this.props.id+'/edit'
    };
    this.handleCheckboxChange = this.handleCheckboxChange.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  };

  handleCheckboxChange = (event)=>{
    this.setState({completed: !this.state.completed});
    this.state.completed= !this.state.completed;
      $.ajax({
        url: '/task/'+this.state.id+'/toggle',
        type: 'POST',
        data: {"id": this.state.id, "completed": this.state.completed}
      });
  };

  handleDelete = (event)=>{
    this.setState({showing: false});
    $.ajax({
      url: '/task/'+this.state.id,
      type: 'DELETE',
      data: {"id": this.state.id}
    });
  };


  render () {
    return (
      <React.Fragment>
      <div style={{ display: (this.state.showing ? 'block' : 'none') }}>
        <label>
          <input type="checkbox" checked={this.state.completed}
              onChange={this.handleCheckboxChange}/>
              <span style={{ textDecoration: (this.state.completed ? "line-through" : 'none') }}>
                {this.state.description}
              </span>
        </label>
        {
          this.state.categories && this.state.categories.map(category => {
            return <a href={category.name} className="collection-item">
            <span className="new badge" data-badge-caption="">{category.name}</span>
            </a>
          })}
        <a onClick={this.handleDelete} className="waves-effect waves-light btn-small right"><i className="material-icons right">delete</i>Delete</a>
        <a href={this.state.edit_link} className="waves-effect waves-light btn-small right">
        <i className="material-icons right">edit</i>Edit</a>
        <hr/>
      </div>
      </React.Fragment>
    );
  }
}

TodoItem.propTypes = {
  id: PropTypes.number,
  description: PropTypes.string,
  completed: PropTypes.bool,
};

export default TodoItem
