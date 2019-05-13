import React from 'react';
import styled from 'styled-components';

import { Collectible } from '../../../util/types';

import { CollectibleAssetContainer } from './collectible_details';

const CollectiblesListWrapper = styled.div``;

interface Props {
    collectibles: Collectible[];
}

export const CollectiblesCardList = (props: Props) => {
    const { collectibles } = props;
    return (
        <CollectiblesListWrapper>
            {collectibles.map((item, index) => {
                const { name, price, image, color, tokenId } = item;
                return (
                    <CollectibleAssetContainer
                        name={name}
                        price={price}
                        image={image}
                        color={color}
                        id={tokenId}
                        key={index}
                    />
                );
            })}
        </CollectiblesListWrapper>
    );
};
