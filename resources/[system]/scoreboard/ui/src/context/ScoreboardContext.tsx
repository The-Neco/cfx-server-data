import { useContext, createContext, useState } from 'react';
import { useNuiEvent } from "../utils/useNuiEvent";

export const ScoreboardContext = createContext<Context | undefined>(undefined);

export const ScoreboardProvider = ({ children }: { children: React.ReactNode }) => {
	const [visibility, setVisibility] = useState<boolean>(false);
	const [columns, setColumns] = useState(null);
	const [players, setPlayers] = useState(null);

	useNuiEvent('CfxScoreboard', 'setVisibility', setVisibility);
	useNuiEvent('CfxScoreboard', 'setPlayers', setPlayers);
	useNuiEvent('CfxScoreboard', 'setColumns', setColumns);

	const value = {
		visibility,
		setVisibility,
		columns,
		setColumns,
		players,
		setPlayers
	}

	return <ScoreboardContext.Provider value={value}>{children}</ScoreboardContext.Provider>
}

interface Context {
	visibility: boolean;
	setVisibility: (show: boolean) => void;
	columns: any;
	setColumns: (columns: any[]) => void;
	players: any;
	setPlayers: (players: any) => void;
}

export const useScoreboard = () => {
	const { visibility, setVisibility } = useContext(ScoreboardContext);
	return { visibility, setVisibility };
}

export const useData = () => {
	const { columns, setColumns } = useContext(ScoreboardContext);
	return { columns, setColumns };
}