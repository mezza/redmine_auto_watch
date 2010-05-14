# Hooks to attach to the Redmine Issues.
class AutoWatchHook < Redmine::Hook::Listener
  def controller_issues_edit_before_save(context = { })
    @issue = context[:issue]
    unless @issue.watched_by?(User.current) || @issue.author == User.current
      @issue.add_watcher(User.current)
    end
    unless @issue.assigned_to == nil || @issue.watched_by?(@issue.assigned_to) || @issue.author == @issue.assigned_to
      @issue.add_watcher(@issue.assigned_to)
    end
  end
end