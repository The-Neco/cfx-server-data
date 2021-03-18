import React from 'react';
import logo from './logo.svg';
import './App.css';
import Scoreboard from "./Scoreboard";
import { useScoreboard } from "./context/ScoreboardContext";
import { useNuiService } from "./utils/useNuiService";

function App() {
  useNuiService();

  const { visibility } = useScoreboard();
  return (
    <div>
      {visibility ? <Scoreboard /> : null}
    </div>
  );
}

export default App;
