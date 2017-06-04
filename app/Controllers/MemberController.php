<?php

namespace App\Controllers;

use Nen\Database\Connection;
use Nen\Database\Query\Insert;
use Nen\Database\Query\Select;
use Nen\Database\Query\Update;
use Nen\Web\Controller;

/**
 * Class MemberController
 */
class MemberController extends Controller
{
    /**
     * @param int $memberId
     */
    public function viewAction(int $memberId)
    {
        Connection::selectAll(new Update('member',
            [
                'first_name' => 'first_name_ttt_' . rand(),
                'last_name' => 'last_name_ttt_' . rand(),
            ],
            'member_id = :memberId', [
                'memberId' => $memberId,
            ]
        ));

        Connection::execute(new Update('member',
            [
                'nikname' => 'nikname_ddd_' . rand(),
            ],
            'member_id = ' . $memberId
        ));

        Connection::execute(new Insert('member', [
            [
                'first_name' => 'first_name_' . rand(),
                'last_name' => 'last_name_' . rand(),
                'nikname' => 'nikname_' . rand(),
                'email' => 'email_' . rand(),
                'password' => 'password_' . rand(),
            ]
        ]));

        $this->response->setJsonContent([
            'memberId' => $memberId,
            'member' => Connection::selectOne(new Select('member', 'member_id = :memberId', [
                'memberId' => $memberId,
            ])),
            'members' => Connection::selectAll(new Select('member')),
        ]);
    }
}
