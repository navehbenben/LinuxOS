#!/bin/bash

previousGameState=0
gameState=0
pOneScore=50
pTwoScore=50
function presentBoard() 
{
	echo " Player 1: $1         Player 2: $2 "
	echo  " --------------------------------- "
	echo  " |       |       #       |       | "
	echo  " |       |       #       |       | "	
	case $3 in
	0)
		echo  " |       |       0       |       | ";;
	1)
		echo  " |       |       #   O   |       | ";;
	2)
		echo  " |       |       #       |   O   | ";;
	3)	
		echo  " |       |       #       |       |O";;
	-1)
		echo  " |       |   O   #       |       | ";;
	-2)
		echo  " |   O   |       #       |       | ";;
	-3)
		echo  "O|       |       #       |       | ";;
	esac
	echo  " |       |       #       |       | "
	echo  " |       |       #       |       | "
	echo  " --------------------------------- "
	if [[ $gameState != 0 ]]
	then
		echo -e "       Player 1 played: ${4}\n       Player 2 played: ${5}\n\n"	
	fi
}



function validityCheck()
{
	local dif=$[$2 - $1]
	if ! [[ $1 =~ ^[0-9]+$ ]] || [[ dif -lt 0 ]] ; 
	then
		echo "NOT A VALID MOVE !"
		return 0;
	fi
	return 1
}

presentBoard $pOneScore $pTwoScore $gameState

while [ 0 ]
do

temp=0
while [ $temp -eq 0 ]
do
	echo "PLAYER 1 PICK A NUMBER: "
	read -s pOnePick
	validityCheck $pOnePick $pOneScore 
	temp=$?
done

pOneScore=$[$pOneScore - $pOnePick]
temp=0

while [ $temp -eq 0 ]
do
	echo "PLAYER 2 PICK A NUMBER: "
	read -s pTwoPick
	validityCheck $pTwoPick $pTwoScore 
	temp=$?
done

pTwoScore=$[$pTwoScore-$pTwoPick]



if [[ $gameState == 0 ]] && [[ $pOnePick != $pTwoPick ]]
then	
	[ $pOnePick -lt $pTwoPick ] && gameState=-1 || gameState=1
	if [[ $pOneScore -eq 0 ]]
	then
		presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick
		echo "PLAYER 1 WINS !"
		break
	elif [[ $pTwoScore -eq 0 ]]
	then
		presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick

		echo "PLAYER 2 WINS !"
		break
	fi
	presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick
	continue
elif [[ $pOnePick == $pTwoPick ]] && [[ $gameState == 0 ]] 
then 
	if [[ $pTwoScore == 0 ]] && [[ $pOneScore == 0 ]]
	then	
		presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick
			echo -e "       Player 1 played: ${pOnePick}\n       Player 2 played: ${pTwoPick}\n\n"	
		echo "IT'S A DRAW !"
		break
	fi
	presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick
	echo -e "       Player 1 played: ${pOnePick}\n       Player 2 played: ${pTwoPick}\n\n"	
	continue
fi




if [[ $pOnePick>$pTwoPick ]] 
then
	if [[ $gameState -gt 0 ]]
	then

		gameState=$[$gameState+1]

	else 

		gameState=1
	fi 	
fi



if [[ $pTwoPick>$pOnePick ]] 
then 
	if [[ $gameState -lt 0 ]]
	then

		gameState=$[$gameState-1]

	else

		gameState=-1
	fi
fi

presentBoard $pOneScore  $pTwoScore $gameState $pOnePick $pTwoPick

if [[ $gameState -eq 3 ]] 
then	
	echo "PLAYER 1 WINS !"
	break
elif [[ $gameState -eq -3 ]]
then
	echo "PLAYER 2 WINS !"
	break
fi

if [[ $pOneScore -eq 0 ]] || [[ $pTwoScore -eq 0 ]]
then
	if [[ $gameState -gt 0 ]]
	then
		echo "PLAYER 1 WINS !"
		break
	elif [[ $gameState -lt 0 ]]
	then
		echo "PLAYER 2 WINS !"
		break
	else 	
		echo "ITS A DRAW"
		break
	fi
fi
done
