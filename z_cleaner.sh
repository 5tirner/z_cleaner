# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    z_cleaner.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: zasabri <zasabri@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/02 20:47:13 by zasabri           #+#    #+#              #
#    Updated: 2023/03/02 20:47:21 by zasabri          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#you space befor cleaning
AT_START=$(df -h | grep "$USER" | awk '{print($4)}' | tr 'i' 'B')
echo "Your Storage Befor cleaning: $AT_START"

#just wait
echo "wait for cleaning..."

if [[ $1 == "--version" ]]; then
    echo "1.0.0"
    exit
fi

# cleanup 42 caches files
rm -rf ~/*42*cache* &> /dev/null
rm -rf ~/.*42* &> /dev/null
rm -rf ~/Library/*42* &> /dev/null
rm -rf ~/Library/.*42* &> /dev/null

# clearing the QuickLook cache
qlmanage -r cache &> /dev/null

# empty the trash
rm -rf ~/.Trash/* &> /dev/null

# cleanup user caches & logs files
rm -rf ~/Library/Caches/* &> /dev/null
rm -rf ~/Library/logs/* &> /dev/null

# cleanup vs code caches
rm -rf ~/Library/Application\ Support/Code/Cache/* &> /dev/null
rm -rf ~/Library/Application\ Support/Code/CachedData/* &> /dev/null

# cleanup XCode derived data and archives
rm -rf ~/Library/Developer/Xcode/DerivedData/* &> /dev/null
rm -rf ~/Library/Developer/Xcode/Archives/* &> /dev/null

# cleanup pip cache
rm -rfv ~/Library/Caches/pip &> /dev/null

# cleanup homebrew cache
if type "brew" &> /dev/null; then
    brew cleanup -s &> /dev/null
    brew cask cleanup &> /dev/null
    rm -rf $(brew --cache) &> /dev/null
    brew tap --repair &> /dev/null
fi

# cleanup npm cache
if type "npm" &> /dev/null; then
    npm cache clean --force &> /dev/null
fi

# cleanup yarn cache
if type "yarn" &> /dev/null; then
    yarn cache clean --force &> /dev/null
fi

#your space after cleaning
IN_THE_END=$(df -h | grep "$USER" | awk '{print($4)}' | tr 'i' 'B')
echo "Your Storage After cleaning: $IN_THE_END"
