import React from 'react';
import ReactDOM from 'react-dom';

// class
class NewComponent extends React.Component {
  render() {
    return (
      <div>hello</div>
    )
  };
};

ReactDOM.render(
  <NewComponent />,
  document.getElementById('root')
)


// function
function AnotherComponent() {
  return (
    <div>hello</div>
  );
};

ReactDOM.render(
  <AnotherComponent />,
  document.getElementById('root')
)


// another way to do function
let YetAnotherComponent = () => {
  return (
    <div>hello</div>
  );
};

ReactDOM.render(
  <YetAnotherComponent />,
  document.getElementById('root')
)


// jsx
let anime = 'Hunter x Hunter';
let element = <div>My favorite anime is {anime}.</div>;
ReactDOM.render(
  element,
  document.getElementById('root')
);


// state
class ClassComponentWithState extends React.Component {
  constructor() {
    this.state = {
      animes: [
        'Hunter x Hunter',
        'One Piece',
        'Neon Genesis Evangelion'
      ],
      recs: []
    };
    this.handleClick = this.handleClick.bind(this)
  };

  handleClick() {
    if (this.state.animes.length !== 0) {
      this.setState(state => ({
        animes: state.animes.slice(0, state.animes.length-1),
        recs: state.recs.push(state.animes[state.animes.length-1])
      }))
    }

    else {
      alert('We have no more anime recommendations for you today! Please return after you have finished watching the ones we have already given you. Good luck!')
    }
  }

  render() {
    let recommended = recs.map(anime => <p style={{margin:'.5em'}}>{anime}</p>)

    return (
      <div style={{display:'block', padding:'1.5em'}}>
        <button 
          style={{padding:'.5em', margin:'1em'}}
          onClick={this.handleClick}>
          Click to get new anime recommendation!
        </button>
        {recommended}
      </div>
    );
  };
};

ReactDOM.render(
  <ClassComponentWithState />,
  document.getElementById('root')
);


// props
let FunctionalComponentWithProps = (props) => {
  return (
    <div style={props.styles}>
      <h1>You should watch the following animes!</h1>
      {props.animes.map(anime => <p>{anime}</p>)}
    </div>
  )
}

let styles = {
  display: 'block',
}

let animes = [
  'Hunter x Hunter',
  'One Piece',
  'Neon Genesis Evangelion'
]

ReactDOM.render(
  <FunctionalComponentWithProps 
    styles={styles}
    animes={animes}
  />,
  document.getElementById('root')
);

