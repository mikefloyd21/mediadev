public class AccountTeamRLCon {
    private List<AccountTeamMember> atm;
    private Account acc; 
    public AccountTeamRLCon(ApexPages.StandardController controller) {
        this.acc= (Account)controller.getRecord();
    }
    public List<AccountTeamMember> getAtm()
    {
        atm = [Select TeamMemberRole, Id, CreatedById, AccountAccessLevel, User.Name from AccountTeamMember where Account.id = :acc.id];
        return atm;
    }
}