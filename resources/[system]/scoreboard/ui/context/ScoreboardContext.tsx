import { useContext, createContext, useState } from 'react';
import { useNuiEvent } from "../utils/useNuiEvent";
import { Columns } from "../types/columns";

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
	columns: Columns[];
	setColumns: (columns: any[]) => void;
	players: any[];
	setPlayers: (players: any) => void;
}

export const useScoreboard = () => {
	const { visibility, setVisibility } = useContext(ScoreboardContext);
	return { visibility, setVisibility };
}

export const useColumns = () => {
	const { columns, setColumns } = useContext(ScoreboardContext);
	return { columns, setColumns };
}

export const usePlayers = () => {
	const { players, setPlayers } = useContext(ScoreboardContext);
	return { players, setPlayers }
}