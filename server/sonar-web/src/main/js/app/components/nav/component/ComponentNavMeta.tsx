/*
 * SonarQube
 * Copyright (C) 2009-2019 SonarSource SA
 * mailto:info AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
import * as React from 'react';
import { connect } from 'react-redux';
import Tooltip from 'sonar-ui-common/components/controls/Tooltip';
import DetachIcon from 'sonar-ui-common/components/icons/DetachIcon';
import { translate } from 'sonar-ui-common/helpers/l10n';
import BranchStatus from '../../../../components/common/BranchStatus';
import Favorite from '../../../../components/controls/Favorite';
import HomePageSelect from '../../../../components/controls/HomePageSelect';
import DateTimeFormatter from '../../../../components/intl/DateTimeFormatter';
import { isBranch, isMainBranch, isPullRequest } from '../../../../helpers/branch-like';
import { isLoggedIn } from '../../../../helpers/users';
import { getCurrentUser, Store } from '../../../../store/rootReducer';
import { BranchLike } from '../../../../types/branch-like';
import ComponentNavWarnings from './ComponentNavWarnings';

export interface Props {
  branchLike?: BranchLike;
  currentUser: T.CurrentUser;
  component: T.Component;
  warnings: string[];
}

export function ComponentNavMeta({ branchLike, component, currentUser, warnings }: Props) {
  const mainBranch = !branchLike || isMainBranch(branchLike);
  const isABranch = isBranch(branchLike);
  const currentPage = getCurrentPage(component, branchLike);
  const displayVersion = component.version !== undefined && isABranch;

  return (
    <div className="navbar-context-meta flex-0">
      {warnings.length > 0 && <ComponentNavWarnings warnings={warnings} />}
      {component.analysisDate && (
        <div className="spacer-left text-ellipsis">
          <DateTimeFormatter date={component.analysisDate} />
        </div>
      )}
      {displayVersion && (
        <Tooltip mouseEnterDelay={0.5} overlay={`${translate('version')} ${component.version}`}>
          <div className="spacer-left text-limited">
            {translate('version')} {component.version}
          </div>
        </Tooltip>
      )}
      {isLoggedIn(currentUser) && (
        <div className="navbar-context-meta-secondary">
          {mainBranch && (
            <Favorite
              component={component.key}
              favorite={Boolean(component.isFavorite)}
              qualifier={component.qualifier}
            />
          )}
          {isABranch && currentPage !== undefined && (
            <HomePageSelect className="spacer-left" currentPage={currentPage} />
          )}
        </div>
      )}
      {isPullRequest(branchLike) && (
        <div className="navbar-context-meta-secondary display-inline-flex-center">
          {isPullRequest(branchLike) && branchLike.url !== undefined && (
            <a
              className="display-inline-flex-center big-spacer-right"
              href={branchLike.url}
              rel="noopener noreferrer"
              target="_blank">
              {translate('branches.see_the_pr')}
              <DetachIcon className="little-spacer-left" size={12} />
            </a>
          )}
          <BranchStatus branchLike={branchLike} component={component.key} />
        </div>
      )}
    </div>
  );
}

export function getCurrentPage(component: T.Component, branchLike: BranchLike | undefined) {
  let currentPage: T.HomePage | undefined;
  if (component.qualifier === 'VW' || component.qualifier === 'SVW') {
    currentPage = { type: 'PORTFOLIO', component: component.key };
  } else if (component.qualifier === 'APP') {
    const branch = isBranch(branchLike) ? branchLike.name : undefined;
    currentPage = { type: 'APPLICATION', component: component.key, branch };
  } else if (component.qualifier === 'TRK') {
    // when home page is set to the default branch of a project, its name is returned as `undefined`
    const branch = isBranch(branchLike) ? branchLike.name : undefined;
    currentPage = { type: 'PROJECT', component: component.key, branch };
  }
  return currentPage;
}

const mapStateToProps = (state: Store) => ({
  currentUser: getCurrentUser(state)
});

export default connect(mapStateToProps)(ComponentNavMeta);
